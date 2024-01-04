<script lang="ts">
    import type { PageData } from './$types'
    export let data: PageData
</script>
  
<svelte:head>
    <title>{data.article?.title}</title>
    <meta name="description" content="投稿詳細ページです" />
</svelte:head>
  
<main>
    <h1>{data.article?.title}</h1>
    <p>{data.article?.publishDate}</p>
    {#each data.article?.images as image}
        <img src="{image.src}" />
    {/each}
    <div>{@html data.article?.description}</div>
</main>