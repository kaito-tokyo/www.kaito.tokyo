<script lang="ts">
    const slug = import.meta.url.split("/").slice(-2)[0]
	const wwwImg = `https://www-img.kaito.tokyo/artworks/${slug}`;
</script>

<svelte:head>
	<title>グレイシアの日2023</title>
</svelte:head>

<article>
	<h1>グレイシアの日2023</h1>
	<section class="metadata">
		<p>投稿日:<time datetime="2023-09-01">2023-09-01</time></p>
	</section>
	<section class="description">
		冷蔵庫に貼ってあるグレイシアの鍵掛けをモデルに練習してみました
	</section>
	<img
		src={`${wwwImg}/2023-09-01-glaceon-day_01.png`}
		width="1600"
		height="1600"
		alt="ブラッキー"
	/>
</article>

<style>
	article {
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
