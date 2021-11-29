const Globetrotters = artifacts.require('Globetrotters')
const OpenWeatherIcon = artifacts.require('OpenWeatherIcon')
const OpenWeatherTemp = artifacts.require('OpenWeatherTemp')

module.exports = async (deployer, network, [defaultAccount]) => {
    
    openWeatherIcon = await OpenWeatherIcon.deployed()
    openWeatherTemp = await OpenWeatherTemp.deployed()

    await deployer.deploy(Globetrotters,
        openWeatherIcon.address,
        openWeatherTemp.address,
        process.env.RINKEBY_VRF_COORDINATOR,
        process.env.RINKEBY_LINKTOKEN,
        process.env.RINKEBY_KEYHASH)
    let glob = await Globetrotters.deployed()
}