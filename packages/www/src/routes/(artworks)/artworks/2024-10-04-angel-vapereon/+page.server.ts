import type { PageServerLoad } from "./$types";
import { dev } from "$app/environment";

export const load = (async () => {
	const youtubeVideoList = await getYouTubeVideoList();
	youtubeVideoList.reverse();
	return {
		articles: [],
		youtubeVideoList: youtubeVideoList.slice(0, 3)
	};
}) satisfies PageServerLoad;
