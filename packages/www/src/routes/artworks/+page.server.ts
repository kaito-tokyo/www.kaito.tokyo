export const prerender = true;

import { type ArtworkArticle, newtClient } from "$lib/server/newt";

import type { PageServerLoad } from "./$types";

export const load = (async () => {
	const { items: articles } = await newtClient.getContents<ArtworkArticle>({
		appUid: "artworks",
		modelUid: "article",
		query: {
			select: ["_id", "title", "slug", "images", "publishedAt"]
		}
	});
	return {
		articles,
    };
}) satisfies PageServerLoad;
