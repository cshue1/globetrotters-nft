const OpenWeatherIcon = artifacts.require('OpenWeatherIcon')
const LinkTokenInterface = artifacts.require('LinkTokenInterface')

module.exports = async (deployer, network, [defaultAccount]) => {
    const openWeatherIcon = await OpenWeatherIcon.deployed()
    const tx = await openWeatherIcon.getWeather()
    console.log('Got weather!', tx)
}