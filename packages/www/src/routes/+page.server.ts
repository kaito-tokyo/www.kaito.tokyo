export const prerender = true;

import { newtClient } from "$lib/server/newt";
import type { IllustrationArticle } from "$lib/server/newt";
import { getYouTubeVideoList } from "$lib/youtube/videos";
import type { PageServerLoad } from "./$types";

export const load = (async () => {
	const { items: articles } = await newtClient.getContents<IllustrationArticle>({
		appUid: "illustration",
		modelUid: "article",
		query: {
			select: ["_id", "title", "slug", "images", "publishedAt"]
		}
	});
	const youtubeVideoList = await getYouTubeVideoList();
	youtubeVideoList.reverse();
	return {
		articles,
		youtubeVideoList: youtubeVideoList.slice(0, 3)
	};
}) satisfies PageServerLoad;
