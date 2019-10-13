using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public class PolyDensity : MonoBehaviour
{
    [MenuItem("Optimise/Show Poly Density")]
    static void ShowPolyDensityMode()
    {
        Shader density = Shader.Find("Optimise/PolyDensity");
        if (density == null)
        {
            return;
        }
        foreach (SceneView view in SceneView.sceneViews)
        {
            view.SetSceneViewShaderReplace(density, "RenderType");
        }
    }

    [MenuItem("Optimise/Hide Poly Density")]
    static void HidePolyDensityMode()
    {
        foreach (SceneView view in SceneView.sceneViews)
        {
            view.SetSceneViewShaderReplace(null, null);
        }
    }
}
