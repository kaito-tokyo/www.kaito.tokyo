<script lang="ts">
	import { formatInTimeZone } from "date-fns-tz";

	import { base } from "$app/paths";

	import type { PageData } from "./$types";

	import { getThumbnail400URL } from "$lib/newt/images";

	export let data: PageData;

	function formatDate(dateString: string): string {
		return formatInTimeZone(new Date(dateString), "Asia/Tokyo", "yyyy-MM-dd");
	}

	const youtubeVideoList = data.youtubeVideoList.flatMap((video) => {
		if (!video.id) {
			return [];
		}

		return [
			{
				title: video.snippet?.title ?? "（タイトルなし）",
				id: video.id,
				thumbnail: video.snippet?.thumbnails?.standard ?? {},
				publishedAt: video.snippet?.publishedAt ?? ""
			}
		];
	});
</script>

<svelte:head>
	<title>Home</title>
	<meta name="description" content="Svelte demo app" />
</svelte:head>

<main>
	<a href="{base}/illustrations"><h1>イラスト</h1></a>
	<section id="illustration-grid" class="grid">
		{#each data.articles as article (article._id)}
			<a href={`illustrations/${article.slug}`}>
				<article>
					<img
						src={getThumbnail400URL(article.images[0].src, ".webp")}
						alt={article.title}
						width={200}
						height={200}
					/>
					<p class="title">{article.title}</p>
					<p class="publishedAt">{formatDate(article.publishedAt)}</p>
				</article>
			</a>
		{/each}
	</section>

	<a href="{base}/youtube"><h1>YouTube</h1></a>
	<section id="youtube-grid" class="grid">
		{#each youtubeVideoList as video (video.id)}
			<a href={`${base}/youtube/${video.id}`}>
				<article>
					<img
						src={video.thumbnail?.url}
						width={video.thumbnail?.width}
						height={video.thumbnail?.height}
						alt={video.title}
					/>
					<p class="title">{video.title}</p>
					<p class="publishedAt">{formatDate(video.publishedAt)}</p>
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
		overflow: auto;
		padding: 20px 25px 0 25px;
	}

	#illustration-grid {
		height: 350px;
	}

	#youtube-grid {
		height: 350px;
	}

	@media (min-width: 720px) {
		.grid {
			grid-template-columns: 1fr 1fr 1fr;
		}
	}

	.grid article {
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

	#youtube-grid img {
		object-fit: contain;
		width: 100%;
		height: 100%;
	}
</style>
