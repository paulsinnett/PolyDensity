using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public class PolyDensity : MonoBehaviour
{
    [MenuItem("Warp/Add Poly Density View Mode")]
    static void AddPolyDensityMode()
    {
        SceneView.AddCameraMode("Polygon Density", "Miscellaneous");
    }
}
