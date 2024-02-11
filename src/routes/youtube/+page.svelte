<script lang="ts">
	import { formatInTimeZone } from "date-fns-tz";
	import { Image } from "@unpic/svelte";

	import { base } from "$app/paths";

	import type { PageData } from "./$types";
	export let data: PageData;

	function formatDate(dateString: string): string {
		return formatInTimeZone(new Date(dateString), "Asia/Tokyo", "yyyy-MM-dd");
	}
</script>

<main>
	<section id="youtube-video-grid" class="grid">
		{#each data.youtubeVideoList as video (video.id)}
			<a href={`${base}/youtube/${video.id}`}>
				<article>
					<Image src={video.snippet.thumbnails.default.url} width={100} height={100} />
					<p class="title">{video.snippet.title}</p>
					<p class="publishedAt">{formatDate(video.snippet.publishedAt)}</p>
				</article>
			</a>
		{/each}
	</section>
</main>

<style>
	.grid {
		display: grid;
		column-gap: 20px;
		row-gap: 20px;
		grid-template-columns: 1fr 1fr;
	}

	@media (min-width: 720px) {
		.grid {
			grid-template-columns: 1fr 1fr 1fr;
		}
	}

	.grid article {
		font-family: "Zen Kaku Gothic New", serif;
		padding: 1vw;
		background: hsl(none none 98%);
		box-shadow: 10px 10px 10px hsl(none none 40%);
		transition: transform 0.1s;
		border-radius: 10px;
	}

	.grid article:hover {
		transform: scale(1.05);
	}

	.grid p {
		margin: 0;
		padding: 0;
	}
</style>
