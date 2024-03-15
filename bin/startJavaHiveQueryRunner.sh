#!/bin/sh

# Check PRESTO_TOP
if [ -z "${PRESTO_TOP}" ]; then
    echo "Set PRESTO_TOP environment variable."
    exit 1
fi

if [ -z "${PRESTO_HOME}" ]; then
    echo "Set PRESTO_HOME environment variable. Where should presto go?"
    exit 1
fi

if [ ! -d "${PRESTO_HOME}/lib" ]; then
    echo "Run uselvl_presto to set up presto."
    exit 1
fi

export DATA_DIR=${PRESTO_HOME}/data
cd ${PRESTO_TOP}
./mvnw exec:java -pl presto-hive -Dexec.mainClass="com.facebook.presto.hive.HiveQueryRunner" -DjvmArgs="-Xmx5G -XX:+ExitOnOutOfMemoryError" -Duser.timezone=America/Bahia_Banderas -Dhive.security=legacy -Dexec.args="${DATA_DIR}" -Dexec.classpathScope=test
