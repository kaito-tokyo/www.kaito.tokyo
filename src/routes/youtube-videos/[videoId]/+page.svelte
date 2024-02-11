<script lang="ts">
	import { formatInTimeZone } from "date-fns-tz";

	import type { PageData } from "./$types";
	import { error } from "@sveltejs/kit";

	export let data: PageData;

	if (!data.youtubeVideo) {
		error(404);
	}

	const video = data.youtubeVideo;

	function formatDate(dateString: string): string {
		return formatInTimeZone(new Date(dateString), "Asia/Tokyo", "yyyy-MM-dd");
	}
</script>

<svelte:head>
	<title>{video.snippet?.title ?? "（タイトルなし）"}</title>
	<meta name="description" content="投稿詳細ページです" />
	<link
		rel="stylesheet"
		href="https://fonts.googleapis.com/css2?family=Zen+Kaku+Gothic+New:wght@300"
	/>
</svelte:head>

<section>
	<article>
		<h1>{video.snippet?.title}</h1>
		<div class="metadata">
			<p>投稿日：{formatDate(video.snippet?.publishedAt ?? "")}</p>
		</div>
		<div>{@html video.snippet?.description}</div>
		<div>{@html video.player?.embedHtml}</div>
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
