export const prerender = true;

import { getYouTubeVideoList } from "$lib/youtube/videos";
import type { PageServerLoad } from "./$types";

export const load = (async ({ params }) => {
	const youtubeVideoList = await getYouTubeVideoList();
	const youtubeVideo = youtubeVideoList.find((video) => video.id === params.videoId);
	return {
		youtubeVideo
	};
}) satisfies PageServerLoad;
