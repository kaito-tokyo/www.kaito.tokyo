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
