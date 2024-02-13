export const prerender = true;

import { getYouTubeVideoList, getYouTubeVideoUrl } from "$lib/youtube/videos";
import type { PageServerLoad } from "./$types";

export const load = (async () => {
	const youtubeVideoList = await getYouTubeVideoList(await getYouTubeVideoUrl());
	youtubeVideoList.reverse();
	return {
		youtubeVideoList
	};
}) satisfies PageServerLoad;
