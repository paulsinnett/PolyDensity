using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DebugPolyDensity : MonoBehaviour
{
    public Shader polyDensity;
    bool replaced = false;

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.D))
        {
            if (replaced)
            {
                Camera.main.SetReplacementShader(null, null);
                replaced = false;
            }
            else
            {
                Camera.main.SetReplacementShader(
                    polyDensity, 
                    "RenderType");

                replaced = true;
            }
        }
    }
}
