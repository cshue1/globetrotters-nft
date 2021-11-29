const OpenWeatherIcon = artifacts.require('OpenWeatherIcon')
const Globetrotters = artifacts.require('Globetrotters')

module.exports = async (deployer, network, [defaultAccount]) => {
    const globeNFT = await Globetrotters.deployed()
    const openWeatherIcon = await OpenWeatherIcon.deployed()
    console.log(await openWeatherIcon.weather())
    console.log(await globeNFT.tokenURI(0))
}