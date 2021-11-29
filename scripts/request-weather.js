const OpenWeatherIcon = artifacts.require('OpenWeatherIcon')

module.exports = async callback => {
    console.log("Requesting...")
    const openWeatherIcon = await OpenWeatherIcon.deployed()
    const tx = await openWeatherIcon.getWeather()
    callback(tx.tx)
}
