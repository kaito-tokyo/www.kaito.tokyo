import { type Request, type Response } from "@google-cloud/functions-framework";
import { type GaxiosResponse } from "gaxios";
import { type youtube_v3 } from "googleapis";

import { googleAuth, storage, youtubeService } from "./constants.js";

export function listVideos(
	params: youtube_v3.Params$Resource$Videos$List
): Promise<GaxiosResponse<youtube_v3.Schema$VideoListResponse> | null | undefined> {
	return new Promise((resolve, reject) => {
		youtubeService.videos.list(params, (err, response) => {
			if (err) {
				reject(err);
			} else {
				resolve(response);
			}
		});
	});
}

export interface GenerateListVideosQueriesResultItem {
	readonly id: string[];
}

export async function handleGenerateVideoListQueries(req: Request, res: Response) {
	const { inputBucket, inputMatchGlob, itemsPerRequest } = req.query;

	if (typeof inputBucket !== "string") {
		throw new Error("Input bucket is invalid!");
	}

	if (typeof inputMatchGlob !== "string") {
		throw new Error("Input match glob is invalid!");
	}

	if (typeof itemsPerRequest !== "string") {
		throw new Error("itemsPerRequest is invalid!");
	}

	const itemsPerRequestInt = parseInt(itemsPerRequest, 10);

	const [files] = await storage.bucket(inputBucket).getFiles({ matchGlob: inputMatchGlob });
	const ids = files.flatMap((f) => {
		const id = f.name.split(/[ .]/)[1];
		return id ? [id] : [];
	});

	const numRequests = Math.ceil(files.length / itemsPerRequestInt);
	const requests: GenerateListVideosQueriesResultItem[] = [];
	for (let i = 0; i < numRequests; i++) {
		requests.push({
			id: ids.slice(i * itemsPerRequestInt, (i + 1) * itemsPerRequestInt)
		});
	}

	res.send(requests);
}

export async function handleSaveVideoList(req: Request, res: Response) {
	const { id, bucket, object } = req.body;

	if (!id || !bucket || !object) {
		throw new Error("Request body is invalid!");
	}

	const [outputExists] = await storage.bucket(bucket).file(object).exists();

	if (outputExists) {
		res.status(204).send("");
		return;
	}

	const response = await listVideos({
		auth: googleAuth,
		part: [
			"contentDetails",
			"id",
			"liveStreamingDetails",
			"localizations",
			"player",
			"recordingDetails",
			"snippet",
			"statistics",
			"status",
			"topicDetails"
		],
		id
	});

	if (!response) {
		throw new Error("Invalid response!");
	}

	await storage.bucket(bucket).file(object).save(JSON.stringify(response.data));

	res.status(204).send("");
}

export async function handleSplitVideoList(req: Request, res: Response) {
	const { inputBucket, inputObject, outputBucket, outputDirectory } = req.query;

	if (
		typeof inputBucket !== "string" ||
		typeof inputObject !== "string" ||
		typeof outputBucket !== "string" ||
		typeof outputDirectory !== "string"
	) {
		throw new Error("Request query is invalid!");
	}

	const response = await storage.bucket(inputBucket).file(inputObject).download();
	const json: youtube_v3.Schema$VideoListResponse = JSON.parse(response[0].toString());
	if (!json.items) {
		throw new Error("Input format is invalid!");
	}

	const outputStorageBucket = storage.bucket(outputBucket);
	for (const item of json.items) {
		if (!item.id || !item.snippet?.publishedAt) {
			throw new Error("Item format is invalid");
		}
		const outputObject = `${outputDirectory}/${item.snippet.publishedAt} ${item.id}.json`;
		await outputStorageBucket.file(outputObject).save(JSON.stringify(item));
	}

	res.status(204).send("");
}

export async function handleComposeVideoList(req: Request, res: Response) {
	const { inputBucket, inputPrefix, outputBucket, outputObject } = req.query;

	if (
		typeof inputBucket !== "string" ||
		typeof inputPrefix !== "string" ||
		typeof outputBucket !== "string" ||
		typeof outputObject !== "string"
	) {
		throw new Error("Request query is invalid!");
	}

	const [inputFiles] = await storage.bucket(inputBucket).getFiles({
		prefix: inputPrefix
	});

	const videoList = await Promise.all(
		inputFiles.map(async (file) => {
			const [contents] = await file.download();
			return JSON.parse(contents.toString());
		})
	);

	const outputFile = storage.bucket(outputBucket).file(outputObject);
	await outputFile.save(JSON.stringify(videoList));
	await outputFile.setMetadata({
		cacheControl: "public, max-age=60"
	});

	res.send({
		outputUrl: outputFile.publicUrl()
	});
}
