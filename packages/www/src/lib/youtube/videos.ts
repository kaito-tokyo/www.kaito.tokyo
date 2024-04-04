import type { youtube_v3 } from "googleapis";

const CHANNEL_ID = "UCfhyVWrxCmdUpst-5n7Kz_Q";
const PUBLIC_BUCKET_NAME = "yf-public-www-kaito-tokyo-1-svc-my1a";
const VIDEOS_URL = `https://storage.googleapis.com/${PUBLIC_BUCKET_NAME}/videos/${CHANNEL_ID}.json`;

let youtubeVideoListCache: youtube_v3.Schema$Video[] = [];

export async function getYouTubeVideoList(): Promise<youtube_v3.Schema$Video[]> {
	if (youtubeVideoListCache.length > 0) {
		return Array.from(youtubeVideoListCache);
	}

	const response = await fetch(VIDEOS_URL);

	if (!response.ok) {
		throw new Error("Invalid format of the index file!");
	}

	const json = (await response.json()) as youtube_v3.Schema$Video[];

	youtubeVideoListCache = json;

	return Array.from(json);
}
