import { http } from "@google-cloud/functions-framework";
import { type GaxiosResponse } from "gaxios";
import { google, type youtube_v3 } from "googleapis";
import { GoogleAuth } from "google-auth-library";
import { type ParsedQs } from "qs";

const service = google.youtube("v3");
const auth = new GoogleAuth({
	scopes: ["https://www.googleapis.com/auth/youtube.readonly"]
});

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

http("youtube-list-search", async (req, res) => {
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
});

function coarceQueryIntoStringArray(q: undefined | string | string[] | ParsedQs | ParsedQs[]) {
	if (typeof q === "string") {
		return [q];
	} else if (Array.isArray(q)) {
		return q.map((e: string | ParsedQs) => e.toString());
	}
}

interface YouYubeListVideosRequest {
	readonly id: string[];
}

http("youtube-list-videos", async (req, res) => {
	const body: YouYubeListVideosRequest = req.body;
	const { id } = body;

	if (typeof id === "undefined") {
		throw new Error("id is invalid!");
	}

	const response = await listVideos({
		auth,
		part: [
			"contentDetails",
			"fileDetails",
			"id",
			"liveStreamingDetails",
			"localizations",
			"player",
			"processingDetails",
			"recordingDetails",
			"snippet",
			"statistics",
			"status",
			"suggestions",
			"topicDetails"
		],
		id
	});

	res.send(response?.data);
});
