import { newtClient } from '$lib/server/newt';
import type { IllustrationArticle } from '$lib/server/newt';
import type { PageServerLoad } from './$types';

export const load = (async () => {
	const { items: articles } = await newtClient.getContents<IllustrationArticle>({
		appUid: 'illustration',
		modelUid: 'article',
		query: {
			select: ['_id', 'title', 'slug', 'images', 'publishedAt']
		}
	});
	return {
		articles
	};
}) satisfies PageServerLoad;
