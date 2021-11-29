const OpenWeatherIcon = artifacts.require('OpenWeatherIcon')

module.exports = async (deployer, network, [defaultAccount]) => {
    // Local (development) networks need their own deployment of the LINK
    // token and the Oracle contract
    await deployer.deploy(OpenWeatherIcon,process.env.ORACLE,process.env.GET_BYTES32_JOBID,process.env.APIKEY)
}