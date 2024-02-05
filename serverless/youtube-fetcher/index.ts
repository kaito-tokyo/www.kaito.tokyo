import { http } from "@google-cloud/functions-framework";
import { type GaxiosResponse } from "gaxios";
import { google, youtube_v3 } from "googleapis";
import { GoogleAuth } from "google-auth-library";

const service = google.youtube("v3");

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

http("youtube-list-search", async (req, res) => {
	const {
		channelId,
		pageToken
	} = req.query;

	if (typeof channelId !== "string") {
		throw new Error("channelId is invalid!");
	}
	
	if (typeof pageToken !== "undefined" && typeof pageToken !== "string") {
		throw new Error("pageToken is invalid!");
	}

	const params: youtube_v3.Params$Resource$Search$List = {
		auth: new GoogleAuth({
			scopes: ["https://www.googleapis.com/auth/youtube.readonly"]
		}),
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
});
