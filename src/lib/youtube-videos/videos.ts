import type { youtube_v3 } from "googleapis";

const CHANNEL_ID = "UCfhyVWrxCmdUpst-5n7Kz_Q";
const PUBLIC_BUCKET_NAME = "www-kaito-tokyo-youtube-fetcher-public";
const INDEX_URL = `https://storage.googleapis.com/${PUBLIC_BUCKET_NAME}/${CHANNEL_ID}/videos/index.json`;

interface YouTubeVideoIndex {
    readonly url: string
}

export async function getYouTubeVideoUrl(indexUrl: string = INDEX_URL): Promise<string> {
    const response = await fetch(indexUrl);

    if (!response.ok) {
        throw new Error("Invalid format of the index file!");
    }

    const { url } = await response.json() as YouTubeVideoIndex

    return url
}

export async function getYouTubeVideoList(url: string): Promise<youtube_v3.Schema$Video[]> {
    const response = await fetch(url);

    if (!response.ok) {
        throw new Error("Invalid format of the index file!");
    }

    const json = await response.json() as youtube_v3.Schema$Video[]

    return json
}
