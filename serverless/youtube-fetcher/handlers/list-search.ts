import { type Request, type Response } from "@google-cloud/functions-framework";
import { type GaxiosResponse } from "gaxios";
import { type youtube_v3 } from "googleapis";

import { googleAuth, youtubeService, storage } from "./constants.js";

function listSearch(
	params: youtube_v3.Params$Resource$Search$List
): Promise<GaxiosResponse<youtube_v3.Schema$SearchListResponse> | null | undefined> {
	return new Promise((resolve, reject) => {
		youtubeService.search.list(params, (err, response) => {
			if (err) {
				reject(err);
			} else {
				resolve(response);
			}
		});
	});
}

export async function handleSaveSearchList(req: Request, res: Response) {
	const { channelId, pageToken, outputBucket, outputObject } = req.query;

	if (
		typeof channelId !== "string" ||
		(typeof pageToken !== "undefined" && typeof pageToken !== "string") ||
		typeof outputBucket !== "string" ||
		typeof outputObject !== "string"
	) {
		throw new Error("Query is invalid!");
	}

	const [outputExists] = await storage.bucket(outputBucket).file(outputObject).exists();

	if (outputExists) {
		res.status(204).send("");
		return;
	}

	const params: youtube_v3.Params$Resource$Search$List = {
		auth: googleAuth,
		part: ["snippet"],
		channelId,
		maxResults: 50,
		order: "date",
		type: ["video"]
	};

	if (pageToken) {
		params.pageToken = pageToken;
	}

	const response = await listSearch(params);

	storage.bucket(outputBucket).file(outputObject).save(JSON.stringify(response?.data));

	res.status(204).send("");
}

export async function handleSplitSearchList(req: Request, res: Response) {
	const { inputBucket, inputObject, outputBucket, outputDirectory } = req.query;

	if (
		typeof inputBucket !== "string" ||
		typeof inputObject !== "string" ||
		typeof outputBucket !== "string" ||
		typeof outputDirectory !== "string"
	) {
		throw new Error("Request query is invalid!");
	}

	const [response] = await storage.bucket(inputBucket).file(inputObject).download();
	const json: youtube_v3.Schema$SearchListResponse = JSON.parse(response.toString());
	if (!json.items) {
		throw new Error("Input format is invalid!");
	}

	const outputStorageBucket = storage.bucket(outputBucket);
	for (const item of json.items) {
		if (!item.id?.videoId || !item.snippet?.publishedAt) {
			throw new Error("Item format is invalid");
		}
		const outputObject = `${outputDirectory}/${item.snippet.publishedAt} ${item.id.videoId}.json`;
		await outputStorageBucket.file(outputObject).save(JSON.stringify(item));
	}

	res.status(204).send("");
}
