<script lang="ts">
	import { formatInTimeZone } from "date-fns-tz";

	import { error } from "@sveltejs/kit";

	import type { PageData } from "./$types";

	import { formatPublishedAt } from "$lib/newt/images";

	export let data: PageData;

	if (!data.article) {
		error(404);
	}

	const { article } = data;
</script>

<svelte:head>
	<title>{article.title}</title>
	<meta name="description" content={`${article.title}: ${article.description}`} />
</svelte:head>

<section>
	<article>
		<h1>{article.title}</h1>
		<section class="metadata">
			<p>投稿日：{formatPublishedAt(article.publishedAt)}</p>
		</section>
		<div>{@html article.description}</div>
		{#each article.images as image}
			<img src={image.src} layout="constrained" width={800} height={800} />
		{/each}
	</article>
</section>

<style>
	section {
		background: hsl(none none 98%);
		border-radius: 20px;
		padding: 10px;
	}

	article .metadata {
		text-align: right;
	}

	article img {
		width: 100%;
		height: 100%;
		object-fit: contain;
	}
</style>
