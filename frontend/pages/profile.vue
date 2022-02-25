<template>
  <div class="container">
    <h1 class="title">
      Sensor Profile
    </h1>
    <button><NuxtLink to="/">Go to Home Page</NuxtLink></button>
    <div class="flex">
        <h2 class="subtitle">
            Sensor Name: {{sensorName}}
        </h2>
        <h2 class="subtitle">
            Sensor Location: {{sensorLocaion}}
        </h2>
    </div>
    <div class="flex">
        <h2 class="subtitle">
            SMS Number: {{smsNumber}}
        </h2>
        <h2 class="subtitle">
            Temperature Threshold: {{threshold}}
        </h2>
    </div>
    <h1 class="title">
        Change Sensor Info
    </h1>
    <div class="flex">
        <div>
            <label class="subtitle">
                Sensor Name:
            </label>
            <input type="text" v-model="newName"/>
        </div>
        <div>
            <label class="subtitle">
                Sensor Location:
            </label>
            <input type="text" v-model="newLocation"/>
        </div>
    </div>
    <div class="flex">
        <div>
            <label class="subtitle">
                SMS Number:
            </label>
            <input type="text" v-model="newNumber"/>
        </div>
        <div>
            <label class="subtitle">
                Temp Threshold:
            </label>
            <input type="text" v-model="newThreshold"/>
        </div>
    </div>
    <button @click="setSensorInfo">
        Set Sensor Info
    </button>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  name: 'IndexPage',
  data() {
    return {
      sensorName: '',
      sensorLocaion: '',
      smsNumber: '',
      threshold: 0,
      baseCloudURL: 'http://localhost:3000/sky/cloud/ckz53u47l0023j2ao80aj1xfx/',
      baseEventURL: 'http://localhost:3000/sky/event/ckz53u47l0023j2ao80aj1xfx/',
      newName: '',
      newLocation: '',
      newNumber: '',
      newThreshold: 0,
    }
  },
  created() {
    this.getsSensorInfo()
  },
  methods: {
    async getsSensorInfo() {
        let response = await axios.get(this.baseCloudURL + 'sensor_profile/get_sensor_info');
        let data = response.data
        this.sensorName = data["name"]
        this.sensorLocaion = data["location"]
        this.smsNumber = data["SMS_receiver"]
        this.threshold = data["threshold"]
    },
    async setSensorInfo() {
        let response = await axios.post(this.baseEventURL + 'none/sensor/profile_update', {
            location: this.newLocation,
            name: this.newName,
            SMS_receiver: this.newNumber,
            threshold: this.newThreshold
        });
        if (response.status !== 200) {
            return;
        }
        this.sensorName = this.newName
        this.sensorLocaion = this.newLocation
        this.smsNumber = this.newNumber
        this.threshold = this.newThreshold
        this.newName = ''
        this.newLocation = ''
        this.newNumber = ''
        this.newThreshold = 0
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

.links {
  padding-top: 15px;
}

.flex {
  flex-direction: row;
  display: flex;
  justify-content: space-evenly;
}

input {
    font-size: 24pt;
}

button {
    margin-top: 30px;
    font-size: 20pt;
}
</style>
