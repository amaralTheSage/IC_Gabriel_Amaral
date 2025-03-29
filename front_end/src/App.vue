<script setup>
import { computed, onMounted, ref, watch } from "vue";
import Pagination from "./components/Pagination.vue";
import TableComponent from "./components/TableComponent.vue";
import Search from "./components/Search.vue";
import axios from "axios";

const data = ref([]);
const query = ref("");
const page = ref(1);

function updatePage(dir) {
  if (dir === "ant" && page.value > 1) {
    page.value -= 1;
  } else if (dir === "prox") {
    page.value += 1;
  }
}

async function set_data() {
  let result;
  try {
    query.value || page.value > 1
      ? (result = await axios.get(
          `http://localhost:8000/?query=${query.value}&page=${page.value}`
        ))
      : (result = await axios.get("http://localhost:8000?page=1"));

    data.value = result.data;
  } catch (error) {
    console.error("Erro buscando os dados:\n", error);
  }
}

onMounted(() => {
  set_data();
});

watch(
  [query, page],
  () => {
    set_data();
  },
  { immediate: true }
);
</script>

<template>
  <main class="w-[85vw] m-auto my-10">
    <Search @update:query="(q) => (query = q)" />
    <TableComponent :data="data" />
    <Pagination @update:page="updatePage" :page="page" :data="data" />
  </main>
</template>
