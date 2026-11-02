// One node per level instead of upstream's two: same app, half the memory.
module.exports = {
    public: {
        origin: process.env.CRYPTPAD_ORIGIN,
        sandboxOrigin: process.env.CRYPTPAD_SANDBOX_ORIGIN,
        // "::" so the Sandbox service reaches this over Railway's private network.
        httpHost: "::",
        httpPort: Number(process.env.PORT) || 3000,
        httpSafePort: 3001,
        httpServerId: "",
    },
    front: [{ host: "localhost", port: 3010 }],
    core: [{ host: "localhost", port: 3020 }],
    storage: [{ host: "localhost", port: 3030, wsPort: 3040 }],
};
