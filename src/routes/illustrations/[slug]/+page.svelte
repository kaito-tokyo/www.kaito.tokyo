<script lang="ts">
	import { Image } from "@unpic/svelte";
	import type { PageData } from './$types';
	export let data: PageData;
</script>

<svelte:head>
	<title>{data.article?.title}</title>
	<meta name="description" content="投稿詳細ページです" />
</svelte:head>

<main>
	<h1>{data.article?.title}</h1>
	<p>{data.article?.publishDate}</p>
	{#each data.article?.images as image}
		<Image
			src={image.src}
			layout="constrained"
			width={800}
			height={800}
		/>
	{/each}
	<div>{@html data.article?.description}</div>
</main>
