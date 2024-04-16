export const prerender = true;

import { type ArtworkArticle, newtClient } from "$lib/server/newt";
import type { PageServerLoad } from "./$types";

export const load = (async ({ params }) => {
	const article = await newtClient.getFirstContent<ArtworkArticle>({
		appUid: "artworks",
		modelUid: "article",
		query: {
			slug: params.slug,
			select: ["_id", "title", "slug", "images", "publishedAt", "description"]
		}
	});
	return {
		article
	};
}) satisfies PageServerLoad;
