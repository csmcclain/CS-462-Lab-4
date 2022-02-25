<template>
  <div class="container">
    <h1 class="title">
      Current Temperature: {{currentTemp}}
    </h1>
    <button><NuxtLink to="/profile">Go to the Sensor Profile</NuxtLink></button>
    <div class="flex">
      <div>
        <h2 class="subtitle">
          Recent Temperature Readings:
        </h2>
        <li v-for="reading in readings" class="moresubtitle">
          Reading of {{reading.temperature}} was logged at {{reading.time}}
        </li>
      </div>
      <div>
        <h2 class="subtitle">
          Temperature Threshold Violations:
        </h2>
        <li v-for="violation in violations" class="moresubtitle">
          A Violation of {{violation.temperature}} was logged at {{violation.time}}
        </li>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  name: 'IndexPage',
  data() {
    return {
      currentTemp: 0,
      readings: [],
      violations: [],
      baseURL: 'http://localhost:3000/sky/cloud/ckz53u47l0023j2ao80aj1xfx/'
    }
  },
  created() {
    this.getAllTemperatures()
    this.getTemperatureViolations()
    
  },
  methods: {
    async getAllTemperatures() {
      let response = await axios.get(this.baseURL + 'temperature_store/temperatures');
      if (response.status !== 200) {
        return;
      }
      this.readings = [];
      for (const [key, value] of Object.entries(response.data)) {
        let newReading = {
          time: key,
          temperature: value['temperature']
        };
        this.readings.push(newReading)
      }
      this.readings = this.readings.reverse()
      this.currentTemp = this.readings[0]['temperature'];
    },
    async getTemperatureViolations() {
      let response = await axios.get(this.baseURL + 'temperature_store/threshold_violations');
      if (response.status !== 200) {
        return;
      }
      this.violations = [];
      for (const [key, value] of Object.entries(response.data)) {
        let newReading = {
          time: key,
          temperature: value['temperature']
        };
        this.violations.push(newReading)
      }
      this.violations = this.violations.reverse();
    }
  },
}
</script>

<style>
.container {
  margin: 0 auto;
  min-height: 100vh;
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

.flex {
  flex-direction: row;
  display: flex
}
</style>
