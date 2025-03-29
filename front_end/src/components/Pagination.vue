<script setup>
import { computed } from "vue";

const props = defineProps({
  data: {
    type: Array,
    default: [],
  },
  page: {
    type: Number,
    default: 1,
  },
});

const emit = defineEmits(["update:page"]);
</script>

<template>
  <div class="flex w-fit ml-auto mt-5 gap-3">
    <!-- Anterior -->
    <button
      v-if="props.page > 1"
      @click="() => emit('update:page', 'ant')"
      class="flex items-center justify-center px-3 h-8 text-sm font-medium text-gray-500 bg-white border border-gray-300 rounded-lg hover:bg-gray-100 hover:text-gray-700"
    >
      <svg
        class="w-3.5 h-3.5 me-2 rtl:rotate-180"
        aria-hidden="true"
        xmlns="http://www.w3.org/2000/svg"
        fill="none"
        viewBox="0 0 14 10"
      >
        <path
          stroke="currentColor"
          stroke-linecap="round"
          stroke-linejoin="round"
          stroke-width="2"
          d="M13 5H1m0 0 4 4M1 5l4-4"
        />
      </svg>
      Anterior
    </button>

    <!-- Próximo -->
    <button
      v-if="props.data.length === 10"
      @click="() => emit('update:page', 'prox')"
      class="flex items-center justify-center px-3 h-8 text-sm font-medium text-gray-500 bg-white border border-gray-300 rounded-lg hover:bg-gray-100 hover:text-gray-700"
    >
      Proximo
      <svg
        class="w-3.5 h-3.5 ms-2 rtl:rotate-180"
        aria-hidden="true"
        xmlns="http://www.w3.org/2000/svg"
        fill="none"
        viewBox="0 0 14 10"
      >
        <path
          stroke="currentColor"
          stroke-linecap="round"
          stroke-linejoin="round"
          stroke-width="2"
          d="M1 5h12m0 0L9 1m4 4L9 9"
        />
      </svg>
    </button>
  </div>
</template>
