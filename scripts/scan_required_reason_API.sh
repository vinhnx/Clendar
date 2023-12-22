#!/bin/bash

# https://developer.apple.com/documentation/bundleresources/privacy_manifest_files/describing_use_of_required_reason_api
searchTerms=(
    # File timestamp APIs
    "creationDate"
    "modificationDate"
    "fileModificationDate"
    "contentModificationDateKey"
    "creationDateKey"
    "getattrlist"
    "getattrlistbulk"
    "fgetattrlist"
    "stat"
    "fstat"
    "fstatat"
    "lstat"
    "getattrlistat"
    # System boot time APIs
    "systemUptime"
    "mach_absolute_time"
    # Disk space APIs
    "volumeAvailableCapacityKey"
    "volumeAvailableCapacityForImportantUsageKey"
    "volumeAvailableCapacityForOpportunisticUsageKey"
    "volumeTotalCapacityKey"
    "systemFreeSize"
    "systemSize"
    "statfs"
    "statvfs"
    "fstatfs"
    "fstatvfs"
    "getattrlist"
    "fgetattrlist"
    "getattrlistat"
    # Active keyboard APIs
    "activeInputModes"
    # User defaults APIs
    "UserDefaults"
)
search_dir="$1"

if [ -z "$search_dir" ]; then
    echo "Usage: $0 <search_dir>"
    exit 1
fi

for pattern in "${searchTerms[@]}"; do
    find "$search_dir" -type f \( -name "*.swift" -o -name "*.m" \) -exec grep -H -Fw "$pattern" {} +
done
