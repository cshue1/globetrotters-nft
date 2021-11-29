const OpenWeatherTemp = artifacts.require('OpenWeatherTemp')

module.exports = async callback => {
    console.log("Requesting...")
    const openWeatherTemp = await OpenWeatherTemp.deployed()
    const tx = await openWeatherTemp.getTemperature()
    callback(tx.tx)
}
