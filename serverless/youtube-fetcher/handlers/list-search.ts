import { type Request, type Response } from "@google-cloud/functions-framework";
import { type GaxiosResponse } from "gaxios";
import { type youtube_v3 } from "googleapis";

import { googleAuth, youtubeService } from "./constants.js";

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

export async function handleListSearch(req: Request, res: Response) {
	const { channelId, pageToken } = req.query;

	if (typeof channelId !== "string") {
		throw new Error("channelId is invalid!");
	}

	if (typeof pageToken !== "undefined" && typeof pageToken !== "string") {
		throw new Error("pageToken is invalid!");
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

	res.send(response?.data);
}
