<script lang="ts">
	import { Image } from "@unpic/svelte";
	import type { PageData } from './$types';
	import { error } from '@sveltejs/kit';
	export let data: PageData;
	if (!data.article) {
		error(404);
	}
	const { article } = data;
</script>

<svelte:head>
	<title>{article.title}</title>
	<meta name="description" content="投稿詳細ページです" />
</svelte:head>

<main>
	<h1>{article.title}</h1>
	<p>{article.publishedAt}</p>
	<div>{@html article.description}</div>
	{#each article.images as image}
		<Image
			src={image.src}
			layout="constrained"
			width={800}
			height={800}
		/>
	{/each}
</main>
