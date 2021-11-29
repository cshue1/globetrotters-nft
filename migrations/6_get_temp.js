const OpenWeatherTemp = artifacts.require('OpenWeatherTemp')
const LinkTokenInterface = artifacts.require('LinkTokenInterface')

module.exports = async (deployer, network, [defaultAccount]) => {
    const openWeatherTemp = await OpenWeatherTemp.deployed()
    const tx = await openWeatherTemp.getTemperature()
    console.log('Got temperature!', tx)
}