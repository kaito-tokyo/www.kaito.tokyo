<script lang="ts">
	import type { PageData } from "./$types";
	import { error } from "@sveltejs/kit";
	import { formatInTimeZone } from "date-fns-tz";
	export let data: PageData;
	if (!data.article) {
		error(404);
	}
	const { article } = data;

	function formatDate(dateString: string): string {
		return formatInTimeZone(new Date(dateString), "Asia/Tokyo", "yyyy-MM-dd");
	}
</script>

<svelte:head>
	<title>{article.title}</title>
	<meta name="description" content="投稿詳細ページです" />
	<link
		rel="stylesheet"
		href="https://fonts.googleapis.com/css2?family=Zen+Kaku+Gothic+New:wght@300"
	/>
</svelte:head>

<section>
	<article>
		<h1>{article.title}</h1>
		<div class="metadata">
			<p>投稿日：{formatDate(article.publishedAt)}</p>
		</div>
		<div>{@html article.description}</div>
		{#each article.images as image}
			<img src={image.src} layout="constrained" width={1600} height={1600} />
		{/each}
	</article>
</section>

<style>
	section {
		background: hsl(none none 98%);
		border-radius: 20px;
		padding: 10px;
	}

	article h1 {
		font-family: "Zen Kaku Gothic New", serif;
	}

	article .metadata {
		text-align: right;
	}
</style>
