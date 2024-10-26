<script lang="ts">
    const slug = import.meta.url.split("/").slice(-2)[0]
	const wwwImg = `https://www-img.kaito.tokyo/artworks/${slug}`;
</script>

<svelte:head>
	<title>ニャオハの日2023</title>
</svelte:head>

<article>
	<h1>ニャオハの日2023</h1>
	<section class="metadata">
		<p>投稿日:<time datetime="2023-09-06">2023-09-06</time></p>
	</section>
	<section class="description">
		ポケモンGOのニャオハのGOスナップショットをなぞってニャオハの練習をしました
	</section>
	<img
		src={`${wwwImg}/2023-09-06-sprigatito-day_01.png`}
		width="1600"
		height="1600"
		alt="ニャオハ主線あり"
	/>
	<img
	    src={`${wwwImg}/2023-09-06-sprigatito-day_02.png`}
		width="1600"
		height="1600"
		alt="ニャオハ主線なし"
	/>
	<img
	    src={`${wwwImg}/2023-09-06-sprigatito-day_03.png`}
		width="1600"
		height="1600"
		alt="ニャオハ背景白"
	/>
	<img
	    src={`${wwwImg}/2023-09-06-sprigatito-day_04.png`}
		width="1600"
		height="1600"
		alt="リーフィア単体"
	/>
	<img
	    src={`${wwwImg}/2023-09-06-sprigatito-day_05.png`}
		width="1600"
		height="1600"
		alt="リーフィア単体"
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
