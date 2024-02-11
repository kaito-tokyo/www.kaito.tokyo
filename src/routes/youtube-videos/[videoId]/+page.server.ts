export const prerender = true;

import { getYouTubeVideoList, getYouTubeVideoUrl } from "$lib/youtube-videos/videos";
import type { PageServerLoad } from "./$types";

export const load = (async ({ params }) => {
    const youtubeVideoList = await getYouTubeVideoList(await getYouTubeVideoUrl());
	const youtubeVideo = youtubeVideoList.find(video => video.id === params.videoId);
	return {
		youtubeVideo
	}
}) satisfies PageServerLoad;
