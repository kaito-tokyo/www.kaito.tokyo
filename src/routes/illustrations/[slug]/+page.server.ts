import { newtClient } from "$lib/server/newt";
import type { IllustrationArticle } from "$lib/server/newt";
import type { PageServerLoad } from "./$types";

export const load = (async ({ params }) => {
	const article = await newtClient.getFirstContent<IllustrationArticle>({
		appUid: "illustration",
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
