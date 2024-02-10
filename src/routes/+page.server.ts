import { newtClient } from "$lib/server/newt";
import type { IllustrationArticle } from "$lib/server/newt";
import type { PageServerLoad } from "./$types";
import { type youtube_v3 } from "googleapis";

export const load = (async () => {
	const { items: articles } = await newtClient.getContents<IllustrationArticle>({
		appUid: "illustration",
		modelUid: "article",
		query: {
			select: ["_id", "title", "slug", "images", "publishedAt"]
		}
	});
	const resp1 = await fetch(
		"https://storage.googleapis.com/www-kaito-tokyo-youtube-fetcher-public/UCfhyVWrxCmdUpst-5n7Kz_Q/videos/index.json"
	);
	const json1 = await resp1.json();
	const resp2 = await fetch(json1.url);
	const youtubeVideos: youtube_v3.Schema$Video[] = await resp2.json();
	youtubeVideos.reverse();
	return {
		articles,
		youtubeVideos
	};
}) satisfies PageServerLoad;
