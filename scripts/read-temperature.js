const OpenWeatherTemp = artifacts.require('OpenWeatherTemp')
const Globetrotters = artifacts.require('Globetrotters')

module.exports = async (deployer, network, [defaultAccount]) => {
    const globeNFT = await Globetrotters.deployed()
    const openWeatherTemp = await OpenWeatherTemp.deployed()
    console.log(await openWeatherTemp.weather())
    console.log(await globeNFT.tokenURI(0))
}