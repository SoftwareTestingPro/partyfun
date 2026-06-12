$files = @(
    @{Path="source/android/app/src/main/res/values-bn/strings.xml"; Name="সোশ্যাল পার্টি গেম: মজার আনন্দ"},
    @{Path="source/android/app/src/main/res/values-gu/strings.xml"; Name="સોશિયલ పార్టీ ગેમ્સ: મજેદાર મજા"},
    @{Path="source/android/app/src/main/res/values-kn/strings.xml"; Name="ಸೋಷಿಯಲ್ ಪಾರ್ಟಿ ಗೇಮ್ಸ್: ಮಜದಾಯಕ ವಿನೋದ"},
    @{Path="source/android/app/src/main/res/values-ml/strings.xml"; Name="സോഷ്യൽ പാർട്ടി ഗെയിംസ്: രസകരമായ വിനോദം"},
    @{Path="source/android/app/src/main/res/values-mr/strings.xml"; Name="सोशल पार्टी गेम्स: मजेशीर मजा"},
    @{Path="source/android/app/src/main/res/values-ta/strings.xml"; Name="சமூக பார்ட்டி கேம்ஸ்: வேடிக்கையான பொழுதுபோக்கு"},
    @{Path="source/android/app/src/main/res/values-te/strings.xml"; Name="సోషల్ పార్టీ గేమ్స్: సరదా వినోదం"}
)

foreach ($file in $files) {
    $content = Get-Content $file.Path
    $newContent = $content -replace '<string name="app_name">.*</string>', ('<string name="app_name">' + $file.Name + '</string>')
    Set-Content -Path $file.Path -Value $newContent
}
