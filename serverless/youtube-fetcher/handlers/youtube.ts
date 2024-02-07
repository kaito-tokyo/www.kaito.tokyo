import { type Request, type Response } from "@google-cloud/functions-framework";
import { type GaxiosResponse } from "gaxios";
import { google, type youtube_v3 } from "googleapis";
import { GoogleAuth } from "google-auth-library";
import { Storage } from "@google-cloud/storage";

const service = google.youtube("v3");
const auth = new GoogleAuth({
	scopes: ["https://www.googleapis.com/auth/youtube.readonly"]
});

const storage = new Storage();

function listSearch(
	params: youtube_v3.Params$Resource$Search$List
): Promise<GaxiosResponse<youtube_v3.Schema$SearchListResponse> | null | undefined> {
	return new Promise((resolve, reject) => {
		service.search.list(params, (err, response) => {
			if (err) {
				reject(err);
			} else {
				resolve(response);
			}
		});
	});
}

export async function handleListSearch(req: Request, res: Response) {
	const { channelId, pageToken } = req.query;

	if (typeof channelId !== "string") {
		throw new Error("channelId is invalid!");
	}

	if (typeof pageToken !== "undefined" && typeof pageToken !== "string") {
		throw new Error("pageToken is invalid!");
	}

	const params: youtube_v3.Params$Resource$Search$List = {
		auth,
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

	res.send(response?.data);
}

function listVideos(
	params: youtube_v3.Params$Resource$Videos$List
): Promise<GaxiosResponse<youtube_v3.Schema$VideoListResponse> | null | undefined> {
	return new Promise((resolve, reject) => {
		service.videos.list(params, (err, response) => {
			if (err) {
				reject(err);
			} else {
				resolve(response);
			}
		});
	});
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

	const [outputExists] = await storage.bucket(bucket).file(object).exists()

	if (outputExists) {
		res.status(204).send("");
		return;
	}

	const response = await listVideos({
		auth,
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
	const body: YouTubeSplitListVideosRequest = req.query;

	const { inputBucket, inputObject, outputBucket, outputDirectory } = body;

	if (!inputBucket || !inputObject || !outputBucket) {
		throw new Error("Request body is invalid!");
	}

	const response = await storage.bucket(inputBucket).file(inputObject).download();
	const json: youtube_v3.Schema$VideoListResponse = JSON.parse(response[0].toString());
	if (!json.items) {
		throw new Error("Input format is invalid!");
	}

	const outputStorageBucket = storage.bucket(outputBucket);
	for (const item of json.items) {
		if (!item.id) {
			throw new Error("Item formait is invalid");
		}
		const outputObject = `${outputDirectory}/${item.id}.json`;
		await outputStorageBucket.file(outputObject).save(JSON.stringify(item));
	}

	res.status(204).send("");
}
