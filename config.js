// Everything that has to survive a redeploy lives on the one volume at /data.
module.exports = {
    ...require("/cryptpad/config.local/config.example.js"),
    filePath: "/data/datastore/",
    archivePath: "/data/data/archive",
    pinPath: "/data/data/pins",
    taskPath: "/data/data/tasks",
    blockPath: "/data/block",
    blobPath: "/data/blob",
    blobStagingPath: "/data/data/blobstage",
    decreePath: "/data/data/decrees",
    logPath: "/tmp/cryptpad-logs",
    logToStdout: true,
    // Upstream's 2 per node is sized for a real server, not a 0.5 GB plan.
    maxWorkers: { core: 1, storage: 1, http: 1, "http-storage": 1 },
    installMethod: "railway",
};
