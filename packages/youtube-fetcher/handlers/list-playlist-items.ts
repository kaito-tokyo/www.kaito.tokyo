import { type Request, type Response } from "@google-cloud/functions-framework";
import { type GaxiosResponse } from "gaxios";
import { type youtube_v3 } from "googleapis";

import { googleAuth, storage, youtubeService } from "./constants.js";

export function listPlaylistItems(
	params: youtube_v3.Params$Resource$Playlistitems$List
): Promise<GaxiosResponse<youtube_v3.Schema$PlaylistItemListResponse> | null | undefined> {
	return new Promise((resolve, reject) => {
		youtubeService.playlistItems.list(params, (err, response) => {
			if (err) {
				reject(err);
			} else {
				resolve(response);
			}
		});
	});
}

export async function handleSavePlaylistItemsList(req: Request, res: Response) {
	const { pageToken, playlistId, outputBucket, outputObject } = req.query;

	if (
		(typeof pageToken !== "undefined" && typeof pageToken !== "string") ||
		typeof playlistId !== "string" ||
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

	const params: youtube_v3.Params$Resource$Playlistitems$List = {
		auth: googleAuth,
		part: ["contentDetails", "id", "snippet", "status"],
		playlistId,
		maxResults: 50
	};

	if (pageToken) {
		params.pageToken = pageToken;
	}

	const response = await listPlaylistItems(params);

	await storage.bucket(outputBucket).file(outputObject).save(JSON.stringify(response?.data));

	res.send({
		nextPageToken: response?.data.nextPageToken
	});
}

export interface PlaylistItems {
	readonly plaulistId: string;
	readonly items: youtube_v3.Schema$PlaylistItem[];
}

export async function handleComposePlaylistItemsList(req: Request, res: Response) {
	const { inputBucket, inputMatchGlob, outputBucket, outputObject } = req.query;

	if (
		typeof inputBucket !== "string" ||
		typeof inputMatchGlob !== "string" ||
		typeof outputBucket !== "string" ||
		typeof outputObject !== "string"
	) {
		throw new Error("Request query is invalid!");
	}

	const [inputFiles] = await storage.bucket(inputBucket).getFiles({
		matchGlob: inputMatchGlob
	});

	const playlistItemsListMap: { [playlistId: string]: youtube_v3.Schema$PlaylistItem[] } = {};
	for (const file of inputFiles) {
		const filename = file.name.split("/").at(-1);
		if (!filename) {
			throw new Error("Invalid object name!");
		}

		const [playlistId] = filename.split(" ");
		if (!playlistId) {
			throw new Error("Invalid filename!");
		}

		const [contents] = await file.download();
		const { items } = JSON.parse(
			contents.toString()
		) as youtube_v3.Schema$PlaylistItemListResponse;
		if (!items) {
			throw new Error("Invalid cached response!");
		}

		const origItems = playlistItemsListMap[playlistId] || [];
		playlistItemsListMap[playlistId] = [...origItems, ...items];
	}

	const playlistItemsList = Object.entries(playlistItemsListMap).map(([playlistId, items]) => ({
		playlistId,
		items
	}));

	const outputFile = storage.bucket(outputBucket).file(outputObject);
	await outputFile.save(JSON.stringify(playlistItemsList));
	await outputFile.setMetadata({
		cacheControl: "public, max-age=60"
	});

	res.send({
		outputUrl: outputFile.publicUrl()
	});
}
