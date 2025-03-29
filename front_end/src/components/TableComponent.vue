<script setup>
defineProps({
  data: Array,
});
</script>

<template>
  <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
    <table class="w-full text-sm text-left rtl:text-right text-gray-500">
      <thead class="text-gray-700 uppercase bg-gray-50 text-sm">
        <tr>
          <th
            scope="col"
            class="text-neutral-500 px-2 py-3 font-medium border-gray-200 border-b text-nowrap"
          >
            Registro ANS
          </th>

          <th
            scope="col"
            class="text-neutral-500 px-2 py-3 font-medium border-gray-200 border-b"
          >
            CNPJ
          </th>

          <th
            scope="col"
            class="text-neutral-500 px-2 py-3 font-medium border-gray-200 border-b"
          >
            Razão Social
          </th>

          <th
            scope="col"
            class="text-neutral-500 px-2 py-3 font-medium border-gray-200 border-b"
          >
            Nome Fantasia
          </th>

          <th
            scope="col"
            class="text-neutral-500 px-2 py-3 font-medium border-gray-200 border-b"
          >
            Cidade
          </th>

          <th
            scope="col"
            class="text-neutral-500 px-2 py-3 font-medium border-gray-200 border-b"
          >
            Email do Representador
          </th>
        </tr>
      </thead>

      <tbody>
        <tr
          v-for="(item, index) in data"
          :key="index"
          class="bg-white border-b border-gray-200 hover:bg-gray-50 px-6 py-4"
        >
          <td v-for="(value, key) in item" :key="key" class="p-2 text-ellipsis">
            {{ value || "-" }}
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
