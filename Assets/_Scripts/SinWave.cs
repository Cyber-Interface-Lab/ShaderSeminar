using System.Collections;
using System.Collections.Generic;
using UnityEngine;

/// <summary>
/// サイン波
/// </summary>
public class SinWave : MonoBehaviour
{
    /// <summary>
    /// マテリアル
    /// </summary>
    private Material material;
    /// <summary>
    /// 縞の本数
    /// </summary>
    [SerializeField]
    private float numOfWaves = 15f;
    /// <summary>
    /// 波の速度（1FixedUpdateごとのテクスチャの移動量）
    /// </summary>
    [SerializeField]
    private float waveSpeed = 1f;
    /// <summary>
    /// オフセットのyの値
    /// </summary>
    private float offset = 0f;
    private void OnEnable()
    {
        material = GetComponent<MeshRenderer>().material;

        offset = 0f;
        material.SetTextureOffset("_MainTex", new Vector2(0f, offset));
        material.SetTextureScale("_MainTex", new Vector2(1f, numOfWaves));
    }
    private void FixedUpdate()
    {
        offset += waveSpeed * Time.fixedDeltaTime;
        material.SetTextureOffset("_MainTex", new Vector2(0f, offset));
    }
}
