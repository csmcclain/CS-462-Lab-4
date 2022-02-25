<template>
  <div class="container">
    <div>
      <h1 class="title">
        Current Temperature: {{currentTemp}}
      </h1>
      <h2 class="subtitle">
        Recent Temperature Readings:
      </h2>
      <li v-for="reading in readings" class="moresubtitle">
        Reading of {{reading.temperature}} was logged at {{reading.time}}
      </li>
      <h2 class="subtitle">
        Temperature Threshold Violations:
      </h2>
      <li v-for="violation in violations" class="moresubtitle">
        A Violation of {{violation.temperature}} was logged at {{violation.time}}
      </li>
    </div>
  </div>
</template>

<script>
export default {
  name: 'IndexPage',
  data() {
    return {
      currentTemp: 72.013,
      readings: [{temperature: 72.013, time: 'now'}],
      violations: [{temperature: 78.0, time: 'earlier'}, ]
    }
  },
}
</script>

<style>
.container {
  margin: 0 auto;
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  text-align: center;
}

.title {
  font-family:
    'Quicksand',
    'Source Sans Pro',
    -apple-system,
    BlinkMacSystemFont,
    'Segoe UI',
    Roboto,
    'Helvetica Neue',
    Arial,
    sans-serif;
  display: block;
  font-weight: 300;
  font-size: 100px;
  color: #35495e;
  letter-spacing: 1px;
}

.subtitle {
  font-weight: 300;
  font-size: 42px;
  color: #526488;
  word-spacing: 5px;
  padding-bottom: 15px;
}

.moresubtitle {
  font-weight: 300;
  font-size: 30px;
  color: #526488;
  word-spacing: 5px;
  padding-bottom: 15px;
}

.links {
  padding-top: 15px;
}
</style>
