using System.IO;
using UnityEditor;
using UnityEditor.Callbacks;
using UnityEditor.iOS.Xcode;

namespace Sentry.Unity.Editor
{
    public class IosPostBuildProcessor
    {
        [PostProcessBuild]
        public static void ChangeXcodePlist(BuildTarget buildTarget, string path)
        {
            if (buildTarget != BuildTarget.iOS)
            {
                return;
            }

            var plistPath = path + "/Info.plist";
            var plist = new PlistDocument();
            plist.ReadFromFile(plistPath);

            var rootDict = plist.root;

            // rootDict.SetString("SentryDSN", "..");

            rootDict.SetBoolean("SentryEnabled", true);

            File.WriteAllText(plistPath, plist.WriteToString());
        }

        [PostProcessBuild(1)]
        public static void OnPostProcessBuild(BuildTarget target, string path)
        {
            if (target != BuildTarget.iOS)
            {
                return;
            }

            var pbxProjectPath = PBXProject.GetPBXProjectPath(path);
            var project = new PBXProject();
            project.ReadFromFile(pbxProjectPath);

            var guid = project.GetUnityMainTargetGuid();

            // TODO: Add Sentry via framework instead of staticlib
            project.AddFrameworkToProject(guid, "Sentry.framework", false);

            // modify frameworks and settings as desired
            File.WriteAllText(pbxProjectPath, project.WriteToString());
        }
    }
}
