using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class Introduction : MonoBehaviour
{
    [SerializeField]
    private GameObject canvas;
    [SerializeField]
    private GameObject panel;
    [SerializeField]
    private GameObject loadingPanel;
    [SerializeField]
    private Slider slider;
    [SerializeField]
    private GameObject water;

    public void LoadGame()
    {
        StartCoroutine(IntroSceneSwitch());
    }

    IEnumerator IntroSceneSwitch()
    {
        DontDestroyOnLoad(water);
        panel.SetActive(false);
        loadingPanel.SetActive(true);
        DontDestroyOnLoad(canvas);

        AsyncOperation operation = SceneManager.LoadSceneAsync(1);

        while (!operation.isDone)
        {
            float progress = Mathf.Clamp01(operation.progress / .9f);

            slider.value = progress;

            yield return null;
        }

        yield return SceneManager.UnloadSceneAsync(0);

        Destroy(water);
        Destroy(canvas);
    }
}
