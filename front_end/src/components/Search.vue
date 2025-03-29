<script setup>
import { ref } from "vue";

const user_input = ref("");
const emit = defineEmits(["update:query"]);
</script>

<template>
  <label for="input-group-1" class="block mb-2 font-medium text-gray-500"
    >Buscar</label
  >
  <form
    class="mb-6 flex items-center w-[450px]"
    @submit="
      (e) => {
        e.preventDefault();
        emit('update:query', user_input);
      }
    "
  >
    <input
      type="text"
      id="input-group-1"
      v-model="user_input"
      class="text-sm rounded-l-lg focus:outline-none w-full p-2 bg-gray-50 border border-gray-300 text-gray-700"
      placeholder="Busque por valores em qualquer coluna"
    />

    <button
      type="submit"
      class="bg-blue-400 text-white py-[6.5px] rounded-r-md px-2"
    >
      <svg
        class="size-6"
        aria-hidden="true"
        xmlns="http://www.w3.org/2000/svg"
        width="24"
        height="24"
        fill="none"
        viewBox="0 0 24 24"
      >
        <path
          stroke="currentColor"
          stroke-linecap="round"
          stroke-width="2"
          d="m21 21-3.5-3.5M17 10a7 7 0 1 1-14 0 7 7 0 0 1 14 0Z"
        />
      </svg>
    </button>
  </form>
</template>
