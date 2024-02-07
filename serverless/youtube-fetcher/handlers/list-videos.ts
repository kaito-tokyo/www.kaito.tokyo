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

export async function handleGenerateListVideosQueries(req: Request, res: Response) {
	const { bucket, matchGlob } = req.query;

	if (typeof bucket !== "string" || typeof matchGlob !== "string") {
		throw new Error("Query is invalid!");
	}

	if (typeof req.query.itemsPerRequest !== "string") {
		throw new Error("itemsPerRequest is invalid!");
	}

	const itemsPerRequest = parseInt(req.query.itemsPerRequest, 10);

	const [files] = await storage.bucket(bucket).getFiles({ matchGlob });
	const ids = files.map((f) => f.name.split(/[ .]/)[1]);

	const numRequests = Math.ceil(files.length / itemsPerRequest);
	const requests: GenerateListVideosQueriesResultItem[] = [];
	for (let i = 0; i < numRequests; i++) {
		requests.push({
			id: ids.slice(i * itemsPerRequest, (i + 1) * itemsPerRequest)
		});
	}

	res.send(requests);
}

export interface YouTubeSaveListVideosRequest {
	readonly id?: string[];
	readonly bucket?: string;
	readonly object?: string;
}

export async function handleSaveListVideos(req: Request, res: Response) {
	const body: YouTubeSaveListVideosRequest = req.body;

	const { id, bucket, object } = body;

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

export interface YouTubeSplitListVideosRequest {
	readonly inputBucket?: string;
	readonly inputObject?: string;
	readonly outputBucket?: string;
	readonly outputDirectory?: string;
}

export async function handleSplitListVideos(req: Request, res: Response) {
	const { inputBucket, inputObject, outputBucket, outputDirectory } = req.query;

	if (
		typeof inputBucket !== "string" ||
		typeof inputObject !== "string" ||
		typeof outputBucket !== "string" ||
		typeof outputDirectory !== "string"
	) {
		throw new Error("Request body is invalid!");
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
